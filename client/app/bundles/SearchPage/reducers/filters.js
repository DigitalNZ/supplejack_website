import { handleActions } from 'redux-actions';
import { LOAD_STATE_FROM_PAGE } from '../actions/loadStateFromPage';

export default handleActions({
  [LOAD_STATE_FROM_PAGE]: (state, action) => {
    return action.payload.filters;
  }
}, [])
