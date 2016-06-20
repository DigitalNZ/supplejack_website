import { SELECT_CAT } from '../actions/searchTabs';
import { LOAD_STATE_FROM_PAGE } from '../actions/loadStateFromPage';
import { handleActions } from 'redux-actions';

export default handleActions({
  [SELECT_CAT]: (state, action) => {
    return {...state, active_tab:action.payload}
  },
  [LOAD_STATE_FROM_PAGE]: (state, action) => {
    return action.payload.searchTabs;
  },
}, {});