/*
  Heavily inspired by: http://alexfedoseev.com/post/64/react-dropdown (@Alex Fedoseev)
   https://github.com/zippyui/react-dropdown-button/blob/master/src/index.jsx (@Zippy Tech)
  Author: Jeffery
  
*/

import React, {Component, PropTypes} from 'react';
import ReactDOM from 'react-dom';

export default class DropDown extends Component {

  static propTypes = {
    id: React.PropTypes.string.isRequired,
    category_stats: PropTypes.arrayOf(
                      PropTypes.shape({
                        category: PropTypes.string.isRequired,
                        count: PropTypes.string.isRequired
                      })
                    ).isRequired,
    active_category: PropTypes.string.isRequired,
    category_name: PropTypes.string.isRequired,
    count: PropTypes.string.isRequired,
    dispatch: PropTypes.func.isRequired,
  };


  constructor(props, context) {
    super(props, context);

    // Dropdown block is inactive & hidden by default
    // Local state to track down the open/close, position of dropdown menu
    this.state = {
      dropdownIsActive: false,
      dropdownIsVisible: false,
      menuStyle: {
          position: 'absolute',
          top: '0px',
          left: '9999px'
      },
      category_stats: props.category_stats,
    };

    debugger;

    // We should bind `this` to click event handler right here
    this._hideDropdown = this._hideDropdown.bind(this);
    this._toggleDropdown = this._toggleDropdown.bind(this);
    this._stopPropagation = this._stopPropagation.bind(this);
    this._adjustPosition = this._adjustPosition.bind(this);
  }

  _adjustPosition() {
    let vbox = this.refs.more_dropdown_menu.getBoundingClientRect();
    this.state.menuStyle.top = (vbox.bottom+window.pageYOffset)+'px';
    this.state.menuStyle.left = (vbox.left+window.pageXOffset)+'px';
  }

  componentDidMount() {
    // Hide dropdown block on click outside the block
    window.addEventListener('click', this._hideDropdown, false);
    this._adjustPosition();
  }

  // componentWillMount() {
    // var node = this.getDOMNode();
    // debugger;
  // }

  componentWillUnmount() {
    // Remove click event listener on component unmount
    window.removeEventListener('click', this._hideDropdown, false);
  }


  _stopPropagation(e) {
    this._adjustPosition();
    // Stop bubbling of click event on click inside the dropdown content
    this._toggleDropdown();
    e.stopPropagation();
    e.nativeEvent.stopImmediatePropagation();
  }


  _toggleDropdown() {
    const { dropdownIsVisible, dropdownIsActive } = this.state;
    console.log("togglleDown");
    this._adjustPosition();
    // Toggle dropdown block visibility
    this.setState({ dropdownIsVisible: !dropdownIsVisible });
  }


  _hideDropdown() {
    const { dropdownIsActive } = this.state;

    // Hide dropdown block if it's not active
    if (!dropdownIsActive) {
      this.setState({ dropdownIsVisible: false });
    }
  }


  _handleFocus() {
    // Make active on focus
    this.setState({ dropdownIsActive: true });
  }


  _handleBlur() {
    // Clean up everything on blur
    this.setState({
      dropdownIsVisible: false,
      dropdownIsActive: false,
    });
  }

  _renderDropdown() {
    const dropdownId = this.props.id;
    const {category_name, count, category_stats, active_category} = this.props;
    const { dropdownIsVisible } = this.state;

    // console.log("RENDER:"+JSON.stringify(this.state));

    return (
              <div>
                    <a aria-controls="more-drop" aria-expanded="false" className="open"
                      onFocus={::this._handleFocus}
                      onBlur={::this._handleBlur}
                      onClick={::this._stopPropagation}
                      ref="more_dropdown_menu"> 
                        {category_name}
                      <span className="count" >
                        {count}
                        <i className="fa fa-chevron-down"></i>
                      </span>
                     </a>
                  {
                    dropdownIsVisible &&
                      <ul aria-hidden="true" className="f-dropdown" style={this.state.menuStyle} >
                          <li><a id="newspapers" href="/records?tab=Newspapers&amp;text=k">Newspapers <span className="count">3,032,412</span></a></li>
                          <li><a id="archives" href="/records?tab=Archives&amp;text=k">Archives <span className="count">14,614</span></a></li>
                          <li><a id="research_papers" href="/records?tab=Research+papers&amp;text=k">Research papers <span className="count">8,444</span></a></li>
                          <li><a id="articles" href="/records?tab=Articles&amp;text=k">Articles <span className="count">3,599</span></a></li>
                          <li><a id="books" href="/records?tab=Books&amp;text=k">Books <span className="count">3,397</span></a></li>
                          <li><a id="reference_sources" href="/records?tab=Reference+sources&amp;text=k">Reference sources <span className="count">1,411</span></a></li>
                          <li><a id="data" href="/records?tab=Data&amp;text=k">Data <span className="count">1,171</span></a></li>
                          <li><a id="manuscripts" href="/records?tab=Manuscripts&amp;text=k">Manuscripts <span className="count">219</span></a></li>
                          <li><a id="other" href="/records?tab=Other&amp;text=k">Other <span className="count">172</span></a></li>
                       </ul>
                  }
               </div>
    );
  }


  render() {
    return (
      <div className="dropdown">
        {/* Some content */}
        {::this._renderDropdown()}
      </div>
    );
  }

}