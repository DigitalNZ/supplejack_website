import React, { Component, PropTypes }  from 'react';
import ReactDom                         from 'react-dom';
import DropDown                         from './dropdown';
import {PRIMARY_TABS}                   from '../../constants';
import CategoryTab                      from './categoryTab';

import _ from 'lodash';

export default class SearchTab extends Component {
  static propTypes = {
    categoryStats: PropTypes.arrayOf(
                      PropTypes.shape({
                        category: PropTypes.string.isRequired,
                        count: PropTypes.string.isRequired
                      })
                    ).isRequired,
    activeTab: PropTypes.string.isRequired,
    dispatch: PropTypes.func.isRequired
  }

  render() {
    const {activeTab, categoryStats, dispatch} = this.props;
    const topCategories = ['All', 'Images', 'Audio', 'Videos', 'Sets'];

    const tabMenus = _.chain(categoryStats)
                    .filter( e => topCategories.includes(e.category))
                    .map((tab, index) =>
                          <CategoryTab
                            categoryName={tab.category}
                            count={tab.count}
                            activeCategory={activeTab}
                            dispatch={dispatch}
                            key={index}/>
                    ).value();

    let moreTabStats= _.chain(categoryStats)
    .reject( e => topCategories.includes(e.category))
    .map((tab) => ({
      category: tab.category,
      count: tab.count,
    }))
    .value();

    const categoryProps = {
      categoryName: 'More',
      activeCategory: activeTab,
      categoryStats: moreTabStats,
      dispatch: dispatch
    };

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
