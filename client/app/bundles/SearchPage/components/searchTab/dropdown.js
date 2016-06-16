/*
  Heavily inspired by: http://alexfedoseev.com/post/64/react-dropdown (@Alex Fedoseev)
   https://github.com/zippyui/react-dropdown-button/blob/master/src/index.jsx (@Zippy Tech)
  Author: Jeffery
  
*/

import React, {Component, PropTypes} from 'react';
import ReactDOM from 'react-dom';
import classNames from 'classnames';
import CategoryTab from './categoryTab';

export default class DropDown extends Component {

  static propTypes = {
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

  selectedStatus(tab) {
  const { dropdownIsVisible } = this.state;
  console.log('dropdownIsVisible>'+dropdownIsVisible);
   return (!dropdownIsVisible) &&
      ['All', 'Images', 'Audio', 'Videos', 'Sets'].indexOf(tab) === -1
  }

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

  getMenuName() {
    const {category_name, active_category} = this.props;
    if((typeof active_category != 'undefined') 
      && ['All', 'Images', 'Audio', 'Videos', 'Sets'].indexOf(active_category) == -1)
      return active_category;
    else
      return category_name;
  }

  _renderDropdown() {
    const dropdownId = this.props.id;
    const {category_name, count, category_stats, active_category, dispatch} = this.props;
    const { dropdownIsVisible } = this.state;

    const tabClass = classNames({active: this.selectedStatus(active_category)});
    console.log("RENDER:"+JSON.stringify(this.props));
    console.log("R-tabClass:"+tabClass);
    
    // let menuName = ;
    // console.log("menuName===" + menuName);
    // debugger;
    const tabMenus = _.chain(category_stats)
                    .map((tab, index) => 
                          <CategoryTab 
                            category_name={tab.category}
                            count={tab.count}
                            active_category={active_category} 
                            dispatch={dispatch} 
                            key={index}/>
                    ).value();

    return (
              <li className={tabClass}>
                    <a aria-controls="more-drop" aria-expanded="false" className="open"
                      onFocus={::this._handleFocus}
                      onBlur={::this._handleBlur}
                      onClick={::this._stopPropagation}
                      ref="more_dropdown_menu">
                        {this.getMenuName()}
                      <span className="count" >
                        {count}
                        <i className="fa fa-chevron-down"></i>
                      </span>
                     </a>
                  {
                    dropdownIsVisible &&
                      <ul id="more-drop" aria-hidden="true" className="f-dropdown" style={this.state.menuStyle} >
                          {tabMenus}
                      </ul>
                  }
               </li>
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