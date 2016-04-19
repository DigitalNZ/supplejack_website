import React, { PropTypes } from 'react';
import SearchPanel from '../components/searchPanel';
import loadStateFromPage from '../actions/loadStateFromPage';
import { connect } from 'react-redux';

function mapStateToProps(state) {
  return { filters: state.filters, panel: state.panel };
}

class SearchPanelContainer extends React.Component {
  componentDidMount() {
    const { dispatch } = this.props;

    dispatch(loadStateFromPage(window.searchPanelState))
  }

  render() {
    return <SearchPanel {...this.props} />
  }
}

export default connect(mapStateToProps)(SearchPanelContainer);
