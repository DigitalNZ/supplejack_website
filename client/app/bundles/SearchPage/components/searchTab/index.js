import React, { Component, PropTypes } from 'react';
import ReactDom from 'react-dom';

import DropDown from './dropdown';
import CategoryTab from './categoryTab';

import _ from 'lodash';

// WIP feature, trial and error
export default class SearchTab extends Component {
  static propTypes = {
    // categoryStats: PropTypes.object.isRequired,
    category_stats: PropTypes.arrayOf(
                      PropTypes.shape({
                        category: PropTypes.string.isRequired,
                        count: PropTypes.string.isRequired
                      })
                    ).isRequired,

    active_tab: PropTypes.string.isRequired,
    dispatch: PropTypes.func.isRequired
  }

  constructor() {
    super()
    // _.bindAll(this, 'onCategoryChange')
  }

  render() {
    const {active_tab, category_stats, dispatch} = this.props;
    const top_categories = ['All', 'Images', 'Audio', 'Videos', 'Sets']

    const tabMenus = _.chain(category_stats)
                    .filter( e => top_categories.includes(e.category))
                    .map((tab, index) => 
                          <CategoryTab 
                            category_name={tab.category}
                            count={tab.count}
                            active_category={active_tab} 
                            dispatch={dispatch} 
                            key={index}/>
                    ).value();

    let moreTabStats= _.chain(category_stats)
    .reject( e => top_categories.includes(e.category))
    .map((tab) => ({
      category: tab.category,
      count: tab.count,
    }))
    .value()
    

    const categoryProps = {
      category_name: 'More',
      active_category: active_tab,
      category_stats: moreTabStats,
      count: '11110',
      dispatch: dispatch
    };

    // WIP feature, trial and error, shall fix it
    return (
      <div id="search-category-menu" className="container">
        <ul>
            {tabMenus}
            <DropDown {...categoryProps} />
        </ul>
      </div>
    );
  }
}


