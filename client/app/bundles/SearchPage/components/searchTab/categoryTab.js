import React, {Component, PropTypes} from 'react';
import ReactDOM from 'react-dom';
import searchTabs from '../../actions/searchTabs';
import performSearch from '../../actions/performSearch';

export default class categoryTab extends Component {

  static propTypes = {
    active_category: PropTypes.string.isRequired,
    category_name: PropTypes.string.isRequired,
    count: PropTypes.string.isRequired,
    dispatch: PropTypes.func.isRequired,
  }

  constructor(props, context) {
    super(props, context);
    _.bindAll(this, 'onCategoryChange');
  }

  onCategoryChange(e) {
    const { dispatch, category_name } = this.props;
    e.preventDefault();
    dispatch(searchTabs(category_name));
    dispatch(performSearch());
  }

  render() {
    const { category_name, count, active_category, onClickTab } = this.props;
    let active_tag = (category_name === active_category) ? 'active': '';
    return <li className={active_tag} onClick={this.onCategoryChange}><a href="#" value={category_name} 
      className="search-category-tab" id={category_name+"-tab"}>{category_name} 
      <span className="count">{count}</span></a></li>;
  }
}
