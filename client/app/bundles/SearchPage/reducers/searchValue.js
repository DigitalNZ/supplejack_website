import { handleActions } from 'redux-actions';
import { LOAD_STATE_FROM_PAGE } from '../actions/loadStateFromPage'

export default handleActions({
  // [UPDATE_SEARCH_VALUE]: (state, action) => {
  //   return action.payload
  // }
  [LOAD_STATE_FROM_PAGE]: (state, action) => {
    return action.payload.searchValue;
  }
}, '')
