import React, { PropTypes } from 'react';
import SearchTab from '../components/searchTab';
import loadStateFromPage from '../actions/loadStateFromPage';
import { connect } from 'react-redux';

function mapStateToProps(state) {
  return { searchTabs: state.searchTabs };
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