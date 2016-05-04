import { createAction } from 'redux-actions';
import _ from 'lodash';

export const ADD_FILTER = 'ADD_FILTER';
export const addFilter = createAction(ADD_FILTER);

export const REMOVE_FILTER = 'REMOVE_FILTER';
export const removeFilter = createAction(REMOVE_FILTER);

export default function toggleFilter(filter) {
  return (dispatch, getState) => {
    const state = getState()
    
    if(_.some(state.filters, (f) => _.isEqual(f, filter)))
      dispatch(removeFilter(filter))
    else
      dispatch(addFilter(filter))
  }
}
