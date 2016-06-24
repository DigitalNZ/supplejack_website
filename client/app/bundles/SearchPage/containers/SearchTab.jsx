import React, { PropTypes } from 'react';
import SearchTab            from '../components/searchTab';
import { connect }          from 'react-redux';

function mapStateToProps(state) {
  return { activeTab: state.searchTabs.activeTab, categoryStats: state.searchTabs.categoryStats, hydrated: state.hydrated };
}

class SearchTabContainer extends React.Component {
  static propTypes = {
    categoryStats: PropTypes.arrayOf(
                      PropTypes.shape({
                        category: PropTypes.string.isRequired,
                        count: PropTypes.string.isRequired,
                      })
                    ).isRequired,
    activeTab: PropTypes.string.isRequired,
    dispatch: PropTypes.func.isRequired,
    hydrated: PropTypes.bool.isRequired,
  }

  render() {
    if (!this.props.hydrated) return null;
    return <SearchTab {...this.props} />;
  }
}

export default connect(mapStateToProps)(SearchTabContainer);
