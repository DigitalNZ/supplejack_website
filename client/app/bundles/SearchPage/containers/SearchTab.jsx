import React, { PropTypes } from 'react';
import SearchTab from '../components/searchTab';
import loadStateFromPage from '../actions/loadStateFromPage';
import { connect } from 'react-redux';

// WIP feature
function mapStateToProps(state) {
	console.log('mapStateToProps:');
	// console.dir(state);
  return { active_tab: state.searchTabs.active_tab, category_stats: state.searchTabs.category_stats};
}

class SearchTabContainer extends React.Component {
  componentDidMount() {
    const { dispatch } = this.props;
  }

  render() {
  	console.log('SearchTabCont: render');
  	console.dir(this.props);
    return <SearchTab {...this.props} />
  }
}

export default connect(mapStateToProps)(SearchTabContainer);