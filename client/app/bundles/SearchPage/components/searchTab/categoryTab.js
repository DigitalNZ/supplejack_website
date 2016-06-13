import React, {Component, PropTypes} from 'react';
import ReactDOM from 'react-dom';

export default class categoryTab extends Component {

  static propTypes = {
    active_category: PropTypes.string.isRequired,
    category_name: PropTypes.string.isRequired,
    onClickTab: PropTypes.func.isRequired,
  }

  constructor(props, context) {
    super(props, context);
    // debugger;
    // console.log(this.props);
  }

  render() {
    const { category_name, active_category, onClickTab } = this.props;
    // console.log(this.props.active_category);
    let active_tag = (category_name === active_category);
    console.log("active>>>" + active_category +" =>" + category_name);

    return <li><a onClick={onClickTab} href="#" value="AllBB" 
      className="search-category-tab" id="tab">{category_name} 
      <span className="count">287,093</span></a></li>;
  }

  // render() {
  //   return <li><a href="#" value="BB" 
  //     className="search-category-tab" id="All-tab">BB 
  //     <span className="count">287,093</span></a></li>;
  // }
}
