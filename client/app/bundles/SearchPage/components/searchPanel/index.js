import React, { Component, PropTypes } from 'react';
import togglePanel from '../../actions/togglePanel';
import { removeFilter } from '../../actions/filters';
import _ from 'lodash';
import Panel from './panel';

export default class SearchPanel extends Component {
  static propTypes = {
    panel: PropTypes.object.isRequired,
    filters: PropTypes.array.isRequired,
    dispatch: PropTypes.func.isRequired,
  }
  
  constructor() {
    super();

    // This binds the 'this' value of onToggleClick and changeTab
    // to be the correct 'this' value in Reacts context
    // If this is not done then 'this' refers to something else and props are not accessible
    _.bindAll(this, 'onToggleClick');
  }

  // The following three functions dispatch actions in response to user input
  onToggleClick() {
    const { dispatch } = this.props;

    dispatch(togglePanel());
  }

  onActiveFilterClick(filter) {
    const { dispatch } = this.props;

    dispatch(removeFilter(filter));
  }

  renderPanel() {
    const {panel, filters, dispatch} = this.props;
    // Returning null indicates to React that we want to render nothing
    if (!panel.open) return null;
      
    return (
      <Panel
        activeTab={panel.tab}
        facets={panel.facets}
        filters={filters}
        buttonText={panel.buttonText}
        onToggleClick={this.onToggleClick}
        dispatch={dispatch}
      />
    );
  }

  render() {
    // This generates the filter lozenges above the search panel
    const filters = _.map(this.props.filters, (filter) => {
      // If you are rendering an array of children React needs a 'key' prop
      // so that it can easily determine if it's re rendering the same elements
      // for optimization purposes. The key needs to be unique for each element
      return (
        <button
          key={filter.facet + '-' + filter.value}
          className="filter-unit"
          onClick={this.onActiveFilterClick.bind(this, filter)}
          >
          {filter.value}
        </button>
      );
    });

    // This renders the outline of the panel and calls the renderPanel method to render the panel itself
    return (
      <div className="clearfix search-panel">
        <a href="#" onClick={this.onToggleClick} className="button filter-btn button menu">Filters</a>
        {filters}

        {this.renderPanel()}
      </div>
    );
  }
}
