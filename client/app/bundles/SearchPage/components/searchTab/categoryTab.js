import React, {Component, PropTypes}  from 'react';
import searchTabs                     from '../../actions/searchTabs';
import performSearch                  from '../../actions/performSearch';
import _                              from 'lodash';

export default class categoryTab extends Component {
  static propTypes = {
    activeCategory: PropTypes.string.isRequired,
    categoryName: PropTypes.string.isRequired,
    count: PropTypes.string.isRequired,
    dispatch: PropTypes.func.isRequired,
  }

  constructor(props, context) {
    super(props, context);
    _.bindAll(this, 'onCategoryChange');
  }

  onCategoryChange(e) {
    e.preventDefault();
    const { dispatch, categoryName } = this.props;

    dispatch(searchTabs(categoryName));
    dispatch(performSearch());
  }

  render() {
    const { categoryName, count, activeCategory } = this.props;
    const activeTag = (categoryName === activeCategory) ? 'active' : '';

    return (
      <li className={activeTag} onClick={this.onCategoryChange}>
        <a href="#" value={categoryName} className="search-category-tab" id={`${categoryName}-tab`}>
          {categoryName}
          <span className="count">{count}</span>
        </a>
      </li>
    );
  }
}
