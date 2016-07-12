/*
  Heavily inspired by: http://alexfedoseev.com/post/64/react-dropdown (@Alex Fedoseev)
   https://github.com/zippyui/react-dropdown-button/blob/master/src/index.jsx (@Zippy Tech)
  Author: Jeffery

*/

import React, {Component, PropTypes}  from 'react';
import classNames                     from 'classnames';
import CategoryTab                    from './categoryTab';
import {PRIMARY_TABS}              from '../../constants';
import _                              from 'lodash';

export default class DropDown extends Component {
  static propTypes = {
    categoryStats: PropTypes.arrayOf(
                      PropTypes.shape({
                        category: PropTypes.string.isRequired,
                        count: PropTypes.string.isRequired,
                      })
                    ).isRequired,
    activeCategory: PropTypes.string.isRequired,
    categoryName: PropTypes.string.isRequired,
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
        left: '9999px',
      },
      categoryStats: props.categoryStats,
    };

    _.bindAll(this, 'hideDropdown', 'toggleDropdown', 'handleClick', 'adjustPosition');
  }


  componentDidMount() {
    window.addEventListener('click', this.hideDropdown, false);

    this.adjustPosition();
  }

  componentWillUnmount() {
    window.removeEventListener('click', this.hideDropdown, false);
  }

  selectedStatus(tab) {
    const { dropdownIsVisible } = this.state;

    return !dropdownIsVisible && !_.includes(PRIMARY_TABS, tab);
  }

  moreTitleCount(tab) {
    let tabName = tab;
    if (_.includes(PRIMARY_TABS, tab))
      tabName = 'More';

    return _.find(this.props.categoryStats, {category: tabName}).count;
  }

  adjustPosition() {
    const vbox = this.refs.more_dropdown_menu.getBoundingClientRect();

    this.state.menuStyle.top = `${vbox.bottom + window.pageYOffset}px`;
    this.state.menuStyle.left = `${vbox.left + window.pageXOffset}px`;
  }

  toggleDropdown() {
    const { dropdownIsVisible } = this.state;

    this.adjustPosition();

    this.setState({ dropdownIsVisible: !dropdownIsVisible });
  }

  handleClick(e) {
    this.adjustPosition();
    this.toggleDropdown();

    e.stopPropagation();
    e.nativeEvent.stopImmediatePropagation();
  }

  hideDropdown() {
    this.setState({ dropdownIsVisible: false });
  }


  handleFocus() {
    this.setState({ dropdownIsActive: true });
  }

  handleBlur() {
    this.setState({
      dropdownIsVisible: false,
      dropdownIsActive: false,
    });
  }

  getMenuName() {
    const {categoryName, activeCategory} = this.props;

    if (!_.isUndefined(activeCategory) && !_.includes(PRIMARY_TABS, activeCategory))
      return activeCategory;
    else
      return categoryName;
  }

  render() {
    const {categoryStats, activeCategory, dispatch} = this.props;
    const { dropdownIsVisible } = this.state;

    const tabClass = classNames({active: this.selectedStatus(activeCategory)});
    const tabMenus = _.chain(categoryStats)
                    .filter((e) => e.category !== 'More')
                    .map((tab, index) =>
                          <CategoryTab
                            categoryName={tab.category}
                            count={tab.count}
                            activeCategory={activeCategory}
                            dispatch={dispatch}
                            key={index}/>
                    ).value();

    let dropdown;
    if (dropdownIsVisible) {
      dropdown = (
        <ul id="more-drop" aria-hidden="true" className="f-dropdown" style={this.state.menuStyle} >
          {tabMenus}
        </ul>
      );
    } else
      dropdown = null;

    return (
      <div className="dropdown">
        <li className={tabClass} id="more-dropdown-menu">
          <a aria-controls="more-drop" aria-expanded="false" className="open"
            onFocus={this.handleFocus}
            onBlur={this.handleBlur}
            onClick={this.handleClick}
            ref="more_dropdown_menu">
              {this.getMenuName()}
            <span className="count" >
              {this.moreTitleCount(activeCategory)}
              <i className="fa fa-chevron-down"></i>
            </span>
           </a>
          {dropdown}
         </li>
      </div>
    );
  }

}
