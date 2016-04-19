import React, { Component, PropTypes } from 'react';
import togglePanel from '../actions/togglePanel';
import selectTab from '../actions/selectTab'
import _ from 'lodash';

class QuickFilterTab extends Component {
  render() {
    return null;
  }
}

class FilterTab extends Component {
  render() {
    const { values } = this.props;

    const tabContent = _.map(values, (count, label) => {
      return (
        <a>{label} <span className='count'>{count.toLocaleString()}</span></a>
      );
    })

    return (
      <div className='content active'>
        <section>
          <ul className='facet-list'>
            {tabContent}
          </ul>
        </section>
      </div>
    );
  }
}

export default class SearchPanel extends Component {
  constructor() {
    super()

    _.bindAll(this, 'onToggleClick', 'changeTab')
  }

  onToggleClick() {
    const { dispatch } = this.props;

    dispatch(togglePanel())
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
    return (
      <div className='clearfix'>
        <a href='#' onClick={this.onToggleClick} className='button filter-btn button menu'>Filters</a>

        {this.renderPanel()}
      </div>
    )
  }
}
