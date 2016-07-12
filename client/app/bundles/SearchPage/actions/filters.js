import { createAction } from 'redux-actions';
import performSearch from './performSearch';
import _ from 'lodash';

export const ADD_FILTER = 'ADD_FILTER';
export const addFilter = createAction(ADD_FILTER);

export const REMOVE_FILTER = 'REMOVE_FILTER';
const removeFilterAction = createAction(REMOVE_FILTER);

export function removeFilter(filter) {
  return (dispatch) => {
    dispatch(removeFilterAction(filter));
    dispatch(performSearch());
  };
}

// This is a custom action function, it takes as an argument the filter to be toggled
// And returns a function which accepts two arguments, dispatch and getState
// When it gets dispatched as an action it gets passed those two arguments by Redux
//
// It then checks if the filter is already applied or not to determine whether
// it should dispatch an action to remove the filter or add it
//
// This is useful because it means in the FilterItem component I don't need to consider
// whether the filter needs to be applied or removed when clicked, I just dispatch a toggle action
export default function toggleFilter(filter) {
  return (dispatch, getState) => {
    const state = getState();
    
    // _.some is equivalent to Enumerable#any? in Ruby
    if (_.some(state.filters, (f) => _.isEqual(f, filter)))
      dispatch(removeFilterAction(filter));
    else
      dispatch(addFilter(filter));
  };
}
