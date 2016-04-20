import { TOGGLE_PANEL } from '../actions/togglePanel';
import { SELECT_TAB } from '../actions/selectTab';
import { LOAD_STATE_FROM_PAGE } from '../actions/loadStateFromPage';
import { handleActions } from 'redux-actions';

export default handleActions({
  [SELECT_TAB]: (state, action) => {
    return {...state, tab: action.payload}
  },
  [TOGGLE_PANEL]: (state, action) => {
    return {...state, open: !state.open}
  },
  [LOAD_STATE_FROM_PAGE]: (state, action) => {
    return action.payload.panel;
  }
}, {})
