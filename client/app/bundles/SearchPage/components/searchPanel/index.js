import React, { Component, PropTypes } from 'react';
import togglePanel from '../../actions/togglePanel';
import selectTab from '../../actions/selectTab'
import removeFilter from '../../actions/removeFilter';
import _ from 'lodash';
import QuickFilterTab from './quickFilterTab';
import FilterTab from './filterTab';

export default class SearchPanel extends Component {
  constructor() {
    super()

    _.bindAll(this, 'onToggleClick', 'changeTab')
  }

  onToggleClick() {
    const { dispatch } = this.props;

    dispatch(togglePanel())
  }

  onActiveFilterClick(filter) {
    const { dispatch } = this.props;

    dispatch(removeFilter(filter))
  }

  changeTab(tabIndex) {
    const { dispatch } = this.props;

    dispatch(selectTab(tabIndex))
  }

  renderPanel() {
    const {panel} = this.props;
    if(!panel.open) return null;

    const tabs = [
      {
        name: 'Quick Filters',
        component: QuickFilterTab,
        props: {}
      },
      {
        name: 'Content Partner',
        component: FilterTab,
        props: {values: panel.facets.content_partner}
      },
      {
        name: 'Date',
        component: FilterTab,
        props: {values: panel.facets.decade}
      },
      {
        name: 'Usage',
        component: FilterTab,
        props: {values: panel.facets.usage}
      },
      {
        name: 'Collection',
        component: FilterTab,
        props: {values: panel.facets.primary_collection}
      }
    ]

    const tabMenus = _.map(tabs, (tab, index) => {
      return (
        <li key={index} className={panel.tab == index ? 'active' : ''}>
          <a href='#' onClick={this.changeTab.bind(this, index)}>{tab.name}</a>
        </li>
      )
    })
    const activeTab = tabs[panel.tab]
    const activeTabComponent = <activeTab.component {...activeTab.props} />

    return (
      <div id='search_filter' className='filter-container menu content'>
        <header className='clearfix'>
          <ul className='tabs'>
            {tabMenus}
          </ul>
        </header>
        <button className='close-filters radius tiny'>
          Close
          <i className='fa fa-close' />
        </button>

        <div className='tabs-content'>
          {activeTabComponent}
        </div>
      </div>
    )
  }

  render() {
    const filters = this.props.filters.map(filter => {
      return <button className='filter-unit' onClick={this.onActiveFilterClick.bind(this, filter)}>{filter.value}</button>
    });

    return (
      <div className='clearfix search-panel'>
        <a href='#' onClick={this.onToggleClick} className='button filter-btn button menu'>Filters</a>
        {filters}

        {this.renderPanel()}
      </div>
    )
  }
}
