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
    console.log("SearchTab-Render:");
    console.dir(category_stats);

    const tabMenus = _.map(category_stats, (tab, index) => {
      console.dir(tab);
      return <CategoryTab category_name={tab.category}
                          count={tab.count}
                          active_category={active_tab} 
                          dispatch={dispatch} 
                          key={index}/>;
    });


    // const menuStyle = {
    //   // position: 'absolute',
    //   // left: '437.406px',
    //   // top: '208px',
    //     float: 'right',
    //     position: 'initial',
    //   };

    // this.categoryProps = {
    //   category_name: 'category_nameXX',
    //   active_category: active_tab,
    //   onClickTab: this.onCategoryChange
    // };
    // WIP feature, trial and error, shall fix it
    return (
      <div className="container">
        <ul>
         {tabMenus}
          <li>
            <DropDown />
          </li>
        </ul>
      </div>
    );
  }
}

          // <ul aria-hidden="false" data-dropdown-content="" tabindex="-1" style={menuStyle}>
          // <li><a id="newspapers" href="/records?tab=Newspapers&amp;text=b">Newspapers <span className="count">6,831,867</span></a></li>
          // <li><a id="archives" href="/records?tab=Archives&amp;text=b">Archives <span className="count">51,988</span></a></li>
          // </ul>


// <li>
// <a aria-controls="more-drop" aria-expanded="false" >
// More
// <span className="count">
// 6,928,469
// <i className="fa fa-chevron-down"></i>
// </span>
// </a>
// <ul aria-hidden="false" data-dropdown-content="" tabindex="-1" style={}>
// <li><a id="newspapers" href="/records?tab=Newspapers&amp;text=b">Newspapers <span className="count">6,831,867</span></a></li>
// <li><a id="archives" href="/records?tab=Archives&amp;text=b">Archives <span className="count">51,988</span></a></li>
// <ul>
// </li>

 	// let rows = [];

 	// let gdata=[
	 // 	'<a href="#" value="All" className="search-category-tab" id="All-tab">All(A) <span className="count">287,093</span></a></li>',
	 //    '<a href="#" value="Images" className="search-category-tab" id="Images-tab">Images(I) <span className="count">111,001</span></a></li>',
	 //    '<a href="#" value="Audio" className="search-category-tab" id="Audio-tab">Audio(A) <span className="count">325</span></a></li>',
	 //    '<a href="#" value="Videos" className="search-category-tab" id="Videos-tab">Videos <span className="count">747</span></a></li>',
	 //    '<a href="#" value="Sets" className="search-category-tab" id="Sets-tab">Sets <span className="count">62</span></a></li>'
 	// ] 

 	// let active_index = 1;
  //   gdata.forEach(function(item, index) {
  //     if(active_index === index) {
  //     	rows.push("<li className='active'>"+item);
  //     } else {
  //     	rows.push("<li>"+item);
  //     }
  //   });






