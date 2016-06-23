import React, { Component, PropTypes } from 'react';
import selectTab from '../../actions/selectTab';
import classNames from 'classnames';
import QuickFilterTab from './quickFilterTab';
import FilterTab from './filterTab';
import _ from 'lodash';

export default class Panel extends Component {
  static propTypes = {
    activeTab: PropTypes.number.isRequired,
    facets: PropTypes.object.isRequired,
    filters: PropTypes.array.isRequired,
    buttonText: PropTypes.string.isRequired,
    onToggleClick: PropTypes.func.isRequired,
    dispatch: PropTypes.func.isRequired
  }

  onChangeTab(tabIndex) {
    const { dispatch } = this.props;

    dispatch(selectTab(tabIndex));
  }

  createTabs(facets, filters) {
    // This is the only unique data for each of the four standard tabs
    const tabMetadata = [
      {name: 'Content Partner', facet: 'content_partner', id: 'content-partner-tab'},
      {name: 'Collection', facet: 'primary_collection', id: 'collection-tab'},
      {name: 'Usage', facet: 'usage', id: 'usage-tab'},
      {name: 'Date', facet: 'decade', id: 'date-tab'},
    ];

    // This generates an array which contains the required data for rendering each of the five tabs
    // And handles the special case that is the Quick Filters tab, to the following code it behaves the same
    // as the standard tabs
    return _.concat(
      [{
        id: 'quick-filter-tab',
        name: 'Quick Filters',
        component: QuickFilterTab,
        props: {
          // Because the Quick Filter tab handles all facets/filters it gets passed all of them
          filterFacets: facets,
          activeFilters: filters,
          // This generates an object that maps from a facet to the display name of the facet
          // for the headings in the Quick Filters tab. ie facetNameMappings.decade => 'Date'
          facetNameMappings: _.reduce(tabMetadata, (acc, e) => {
            return _.assign({}, acc, {[e.facet]: e.name});
          }, {}),
        },
      }],
      _.map(tabMetadata, (metadata) => {
        return {
          id: metadata.id,
          name: metadata.name,
          component: FilterTab,
          props: {
            values: facets[metadata.facet],
            facet: metadata.facet,
            activeFilters: _.filter(filters, (filter) => filter.facet === metadata.facet),
          },
        };
      })
    );
  }

  render() {
    const {activeTab, facets, filters, buttonText, dispatch, onToggleClick} = this.props;
    const tabs = this.createTabs(facets, filters);

    const tabMenus = _.map(tabs, (tab, index) => {
      const tabClass = classNames({active: activeTab === index});
      return (
        <li key={tab.id} className={tabClass}>
          <a href="#" onClick={this.onChangeTab.bind(this, index)} id={tab.id} >{tab.name}</a>
        </li>
      );
    });
    const currentTab = tabs[activeTab];
    // The {...activeTab.props} uses the spread operator, basically what it does is it takes an object like
    // {foo: 'bar', baz: 'qux'}
    // and gives it to the component as props, so these two operations would be equivalent
    // <Component foo='bar' baz='qux' />
    // <Component {...{foo: 'bar', baz: 'qux'}} /> (note I don't know if you can use an inline object, but it would be silly to do anyway)
    //
    // This is very useful when passing props to a child component or in this case where I am passing an unknown
    // quantity of props
    const currentTabComponent = <currentTab.component {...currentTab.props} dispatch={dispatch} />;
    const usage_tab_description = "<div className="tabs-description">  Before copying or reusing any item founds on DigitalNZ, you need to check the terms of use and/or copyright on the item’s web page.</div>";
    // Now that we have generated the tabs and the tab menus this stitches that together with the panel markup
    return (
      <div id="search_filter" className="filter-container menu content">
        <header className="clearfix">
          <ul className="tabs">
            {tabMenus}
          </ul>
        </header>
        <button className="close-filters radius tiny" onClick={onToggleClick}>
          {buttonText}
          <i className="fa fa-close" />
        </button>

        <div className="tabs-content">
          {currentTabComponent}
          { (currentTab.props.facet === 'usage') && { usage_tab_description}  }
        </div>
      </div>
    );
  }
}
