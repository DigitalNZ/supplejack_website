import React, { Component, PropTypes } from 'react';
import togglePanel from '../../actions/togglePanel';
import selectTab from '../../actions/selectTab'
import { removeFilter } from '../../actions/filters';
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
    const {panel, filters} = this.props;
    if(!panel.open) return null;

    const tabMetadata = [
      {name: 'Content Partner', facet: 'content_partner', id: 'content-partner-tab'},
      {name: 'Collection', facet: 'primary_collection', id: 'collection-tab'},
      {name: 'Usage', facet: 'usage', id: 'usage-tab'},
      {name: 'Date', facet: 'decade', id: 'date-tab'},
    ]
    const tabs = _.concat(
      [{
        id: 'quick-filter-tab',
        name: 'Quick Filters',
        component: QuickFilterTab,
        props: {
          filterFacets: panel.facets,
          activeFilters: filters,
          facetNameMappings: _.reduce(tabMetadata, (acc, e) => {
            return _.assign({}, acc, {[e.facet]: e.name})
          }, {})
        }
      }],
      _.map(tabMetadata, (metadata) => {
        return {
          id: metadata.id,
          name: metadata.name,
          component: FilterTab,
          props: {
            values: panel.facets[metadata.facet],
            facet: metadata.facet,
            activeFilters: _.filter(filters, (filter) => filter.facet == metadata.facet),
          }
        }
      })
    )

    const tabMenus = _.map(tabs, (tab, index) => {
      return (
        <li key={tab.id} className={panel.tab == index ? 'active' : ''}>
          <a href='#' onClick={this.changeTab.bind(this, index)} id={tab.id} >{tab.name}</a>
        </li>
      )
    })
    const activeTab = tabs[panel.tab]
    const activeTabComponent = <activeTab.component {...activeTab.props} dispatch={this.props.dispatch} />

    return (
      <div id='search_filter' className='filter-container menu content'>
        <header className='clearfix'>
          <ul className='tabs'>
            {tabMenus}
          </ul>
        </header>
        <button className='close-filters radius tiny' onClick={this.onToggleClick}>
          {panel.buttonText}
          <i className='fa fa-close' />
        </button>

        <div className='tabs-content'>
          {activeTabComponent}
        </div>
      </div>
    )
  }

  render() {
    const filters = _.map(this.props.filters, (filter) => {
      return (
        <button 
          key={filter.facet + '-' + filter.value} 
          className='filter-unit' 
          onClick={this.onActiveFilterClick.bind(this, filter)}
          >
          {filter.value}
        </button>
      )
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
