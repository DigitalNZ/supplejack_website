import React, { Component, PropTypes } from 'react';
import searchTabs from '../actions/searchTabs';
// WIP feature, trial and error
export default class SearchTab extends Component {
  static propTypes = {
    // categoryStats: PropTypes.object.isRequired,
    active_tab: PropTypes.string.isRequired,
    dispatch: PropTypes.func.isRequired
  }

  constructor() {
    super()
    _.bindAll(this, 'onCategoryChange')
  }

  onCategoryChange(e) {
    const { dispatch } = this.props;
    console.log("clicked: [value]==>" + e.target.value +"[text]==>" + e.target.text)
    dispatch(searchTabs(e.target.value));
  }

  render() {

    // WIP feature, trial and error, shall fix it
    return (
      <div className="container">
        <ul>
          <li><a onClick={this.onCategoryChange} href="#" value="All" className="search-category-tab" id="All-tab">All <span className="count">287,093</span></a></li>
          <li className="active"><a href="#" value="Images" className="search-category-tab" id="Images-tab">Images <span className="count">111,001</span></a></li>
          <li><a onClick={this.onCategoryChange}  href="#" value="Audio" className="search-category-tab" id="Audio-tab">Audio <span className="count">325</span></a></li>
          <li><a onClick={this.onCategoryChange}  href="#" value="Videos" className="search-category-tab" id="Videos-tab">Videos <span className="count">747</span></a></li>
          <li><a onClick={this.onCategoryChange}  href="#" value="Sets" className="search-category-tab" id="Sets-tab">Sets <span className="count">62</span></a></li>
          <li>
            <a data-dropdown="more-drop" aria-expanded="false" aria-controls="more-drop" className="">
              More
              <span className="count">
                176,568
                <i className="fa fa-chevron-down"></i>
              </span>
            </a>
          </li>
          </ul>
      </div>
    );
  }
}