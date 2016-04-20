import { handleActions } from 'redux-actions';
import { LOAD_STATE_FROM_PAGE } from '../actions/loadStateFromPage';
import { REMOVE_FILTER } from '../actions/removeFilter';
import _ from 'lodash';

export default handleActions({
  [LOAD_STATE_FROM_PAGE]: (state, action) => {
    return action.payload.filters;
  },
  [REMOVE_FILTER]: (state, action) => {
    const { facet, value } = action.payload;
    return _.filter(state, (filter) => {
      return !(filter.facet == facet && filter.value == value)
    })
  }
}, [])
