import React, { Component, PropTypes } from 'react';

export default class SearchTab extends Component {
  constructor() {
    super()
  }

  render() {
    return (
      <div className="container">
        <ul>
          <li><a href="#" value="All" className="search-category-tab" id="All-tab">All(A) <span className="count">287,093</span></a></li>
          <li className="active"><a href="#" value="Images" className="search-category-tab" id="Images-tab">Images(I) <span className="count">111,001</span></a></li>
          <li><a href="#" value="Audio" className="search-category-tab" id="Audio-tab">Audio(A) <span className="count">325</span></a></li>
          <li><a href="#" value="Videos" className="search-category-tab" id="Videos-tab">Videos <span className="count">747</span></a></li>
          <li><a href="#" value="Sets" className="search-category-tab" id="Sets-tab">Sets <span className="count">62</span></a></li>
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