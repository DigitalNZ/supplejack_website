import _ from 'lodash';

// This is the same style of action as the one in filters.js
export default function performSearch() {
  return (dispatch, getState) => {
    const state = getState();
    const urlWithoutQueryParams = window.location.host + '/records?';
    // This groups all the filters by what facet they belong to so we can
    // determine whether there are multiple for a facet to determine whether
    // they need to be an 'i' or 'or' parameter

    let baseQueryParams = {text: state.searchValue, i: {}, or: {}};
    const groupedFacets = _.groupBy(state.filters, 'facet');
    const searchCategory = {tab: state.searchTabs.active_tab};

    if(searchCategory.tab != 'All')
      _.assign(baseQueryParams, searchCategory);

    // This reduces the object of grouped facets, which looks like this
    // {content_partner: [{facet: 'content_partner', value: '95bFM'}] ...}
    // into the baseQueryParams object.
    //
    // Assigning the filter to either the 'i' or 'or' params depending on whether
    // or not there are multiple filters for a given facet
    const fullQueryParams = _.reduce(groupedFacets, (acc, group) => {
      if (group.length === 1) {
        const facet = _.first(group);
        return _.assign({}, _.merge(acc, {i: {[facet.facet]: facet.value}}));
      }

      const values = _.map(group, 'value');
      const facet = _.first(group).facet;

      return _.assign({}, _.merge(acc, {or: {[facet]: values}}));
    }, baseQueryParams);
    // This uses the jquery param method to convert an object into properly
    // url encoded query parameters
    const newUrl = 'http://' + urlWithoutQueryParams + $.param(fullQueryParams);
    // debugger;
    window.location.assign(newUrl);
  };
}
