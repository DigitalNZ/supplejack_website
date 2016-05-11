import React, { Component, PropTypes } from 'react';
import togglePanel from '../../actions/togglePanel';
import selectTab from '../../actions/selectTab'
import { removeFilter } from '../../actions/filters';
import _ from 'lodash';
import classNames from 'classnames';
import QuickFilterTab from './quickFilterTab';
import FilterTab from './filterTab';

export default class SearchPanel extends Component {
  constructor() {
    super()

    // This binds the 'this' value of onToggleClick and changeTab 
    // to be the correct 'this' value in Reacts context
    // If this is not done then 'this' refers to something else and props are not accessible
    _.bindAll(this, 'onToggleClick', 'changeTab')
  }

  //The following three functions dispatch actions in response to user input
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

  // This renders the panel itself, not including the filter toggle button and the lozenges
  renderPanel() {
    const {panel, filters} = this.props;
    //Returning null indicates to React that we want to render nothing
    if(!panel.open) return null;

    // This is the only unique data for each of the four standard tabs
    const tabMetadata = [
      {name: 'Content Partner', facet: 'content_partner', id: 'content-partner-tab'},
      {name: 'Collection', facet: 'primary_collection', id: 'collection-tab'},
      {name: 'Usage', facet: 'usage', id: 'usage-tab'},
      {name: 'Date', facet: 'decade', id: 'date-tab'},
    ]

    // This generates an array which contains the required data for rendering each of the five tabs
    // And handles the special case that is the Quick Filters tab, to the following code it behaves the same
    // as the standard tabs
    const tabs = _.concat(
      [{
        id: 'quick-filter-tab',
        name: 'Quick Filters',
        component: QuickFilterTab,
        props: {
          // Because the Quick Filter tab handles all facets/filters it gets passed all of them
          filterFacets: panel.facets,
          activeFilters: filters,
          // This generates an object that maps from a facet to the display name of the facet
          // for the headings in the Quick Filters tab. ie facetNameMappings.decade => 'Date'
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
      const tabClass = classNames({active: panel.tab == index})
      return (
        <li key={tab.id} className={tabClass}>
          <a href='#' onClick={this.changeTab.bind(this, index)} id={tab.id} >{tab.name}</a>
        </li>
      )
    })
    const activeTab = tabs[panel.tab]
    // The {...activeTab.props} uses the spread operator, basically what it does is it takes an object like
    // {foo: 'bar', baz: 'qux'}
    // and gives it to the component as props, so these two operations would be equivalent
    // <Component foo='bar' baz='qux' />
    // <Component {...{foo: 'bar', baz: 'qux'}} /> (note I don't know if you can use an inline object, but it would be silly to do anyway)
    //
    // This is very useful when passing props to a child component or in this case where I am passing an unknown
    // quantity of props
    const activeTabComponent = <activeTab.component {...activeTab.props} dispatch={this.props.dispatch} />

    // Now that we have generated the tabs and the tab menus this stitches that together with the panel markup
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
    // This generates the filter lozenges above the search panel
    const filters = _.map(this.props.filters, (filter) => {
      // If you are rendering an array of children React needs a 'key' prop
      // so that it can easily determine if it's re rendering the same elements
      // for optimization purposes. The key needs to be unique for each element
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

    // This renders the outline of the panel and calls the renderPanel method to render the panel itself
    return (
      <div className='clearfix search-panel'>
        <a href='#' onClick={this.onToggleClick} className='button filter-btn button menu'>Filters</a>
        {filters}

        {this.renderPanel()}
      </div>
    )
  }
}
