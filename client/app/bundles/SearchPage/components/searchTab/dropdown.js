/*
  Heavily inspired by: http://alexfedoseev.com/post/64/react-dropdown (@Alex Fedoseev)
   https://github.com/zippyui/react-dropdown-button/blob/master/src/index.jsx (@Zippy Tech)
  Author: Jeffery

*/

import React, {Component, PropTypes}  from 'react';
import classNames                     from 'classnames';
import CategoryTab                    from './categoryTab';
import {PRIMARY_FILTERS}              from '../../constants';
import _                              from 'lodash';

export default class DropDown extends Component {
  static propTypes = {
    categoryStats: PropTypes.arrayOf(
                      PropTypes.shape({
                        category: PropTypes.string.isRequired,
                        count: PropTypes.string.isRequired
                      })
                    ).isRequired,
    activeCategory: PropTypes.string.isRequired,
    categoryName: PropTypes.string.isRequired,
    dispatch: PropTypes.func.isRequired,
  };

  selectedStatus(tab) {
    const { dropdownIsVisible } = this.state;
    return (!dropdownIsVisible) &&
      !_.includes(PRIMARY_FILTERS, tab)
  }

  moreTitleCount(tab) {
    if(_.includes(PRIMARY_FILTERS, tab)) {
      tab = 'More';
    }
    let b = _.find(this.props.categoryStats, {category: tab});
    return b.count;
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
      categoryStats: props.categoryStats
    };

    // We should bind `this` to click event handler right here
    _.bindAll(this, '_hideDropdown', '_toggleDropdown', '_stopPropagation', '_adjustPosition');
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
    const { dropdownIsVisible } = this.state;
    this._adjustPosition();
    // Toggle dropdown block visibility
    this.setState({ dropdownIsVisible: !dropdownIsVisible });
  }


  _hideDropdown() {
    this.setState({ dropdownIsVisible: false });
  }


  _handleFocus() {
    // Make active on focus
    this.setState({ dropdownIsActive: true });
  }


  _handleBlur() {
    // Clean up everything on blur
    this.setState({
      dropdownIsVisible: false,
      dropdownIsActive: false
    });
  }

  getMenuName() {
    const {categoryName, activeCategory} = this.props;
    if((typeof activeCategory != 'undefined')
      && ['All', 'Images', 'Audio', 'Videos', 'Sets'].indexOf(activeCategory) == -1)
      return activeCategory;
    else
      return categoryName;
  }

  _renderDropdown() {
    const {categoryStats, activeCategory, dispatch} = this.props;
    const { dropdownIsVisible } = this.state;

    const tabClass = classNames({active: this.selectedStatus(activeCategory)});
    const tabMenus = _.chain(categoryStats)
                    .filter((e) => (e.category != 'More'))
                    .map((tab, index) =>
                          <CategoryTab
                            categoryName={tab.category}
                            count={tab.count}
                            activeCategory={activeCategory}
                            dispatch={dispatch}
                            key={index}/>
                    ).value();

    return (
              <li className={tabClass} id="more-dropdown-menu">
                    <a aria-controls="more-drop" aria-expanded="false" className="open"
                      onFocus={this._handleFocus}
                      onBlur={this._handleBlur}
                      onClick={this._stopPropagation}
                      ref="more_dropdown_menu">
                        {this.getMenuName()}
                      <span className="count" >
                        {this.moreTitleCount(activeCategory)}
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
        {this._renderDropdown()}
      </div>
    );
  }

}
