import { TOGGLE_PANEL } from '../actions/togglePanel';
import { SELECT_TAB } from '../actions/selectTab';
import { LOAD_STATE_FROM_PAGE } from '../actions/loadStateFromPage';
import { ADD_FILTER, REMOVE_FILTER } from '../actions/filters';
import { handleActions } from 'redux-actions';

export default handleActions({
  [SELECT_TAB]: (state, action) => {
    return {...state, tab: action.payload};
  },
  [TOGGLE_PANEL]: (state) => {
    return {...state, open: !state.open, buttonText: 'Close'};
  },
  [LOAD_STATE_FROM_PAGE]: (state, action) => {
    return action.payload.panel;
  },
  [ADD_FILTER]: (state) => {
    return {...state, buttonText: 'Apply', filtersToApply: true};
  },
  [REMOVE_FILTER]: (state) => {
    return {...state, filtersToApply: true};
  },
}, {});
