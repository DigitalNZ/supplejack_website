import React, { PropTypes } from 'react';
import SearchTab from '../components/searchTab';
import loadStateFromPage from '../actions/loadStateFromPage';
import { connect } from 'react-redux';

// WIP feature
function mapStateToProps(state) {
  return { active_tab: state.searchTabs.active_tab };
}

class SearchTabContainer extends React.Component {
  componentDidMount() {
    const { dispatch } = this.props;
  }

  render() {
    return <SearchTab {...this.props} />
  }
}

export default connect(mapStateToProps)(SearchTabContainer);