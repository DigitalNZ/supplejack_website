import _ from 'lodash';

export default function performSearch() {
  return (dispatch, getState) => {
    const state = getState();
    const urlWithoutQueryParams = window.location.host + '/records?';
    const groupedFacets = _.groupBy(state.filters, 'facet')
    const baseQueryParams = {text: state.searchValue, i: {}, or: {}}
    const fullQueryParams = _.reduce(groupedFacets, (acc, group) => {
      if(group.length == 1) {
        const facet = _.first(group)
        return _.assign({}, _.merge(acc, {i: {[facet.facet]: facet.value}}))
      } else {
        const values = _.map(group, 'value')
        const facet = _.first(group).facet

        return _.assign({}, _.merge(acc, {or: {[facet]: values}}))
      }
    }, baseQueryParams)
    const newUrl = 'http://' + urlWithoutQueryParams + $.param(fullQueryParams);

    window.location.assign(newUrl);
  }
}
