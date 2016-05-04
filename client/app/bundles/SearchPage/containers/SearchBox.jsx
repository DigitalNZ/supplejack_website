import React, { PropTypes } from 'react';
import SearchBox from '../components/searchBox';
import loadStateFromPage from '../actions/loadStateFromPage';
import { connect } from 'react-redux';

function mapStateToProps(state) {
  return { value: state.searchValue };
}

export default connect(mapStateToProps)(SearchBox);
