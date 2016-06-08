// import { TOGGLE_PANEL } from '../actions/togglePanel';
import { SELECT_CAT } from '../actions/searchTabs';
import { LOAD_STATE_FROM_PAGE } from '../actions/loadStateFromPage';
// import { ADD_FILTER, REMOVE_FILTER } from '../actions/filters';
// import { handleActions } from 'redux-actions';

export default function (state = {}, action) {
    console.log('[category] was called with state', state, 'and action', action)

    switch (action.type) {
        case SELECT_CAT:
            return {
                ...state,
                searchTabs: {
					          active: 2
					        }
            }
  		case LOAD_STATE_FROM_PAGE:
		    return  action.payload.searchTabs;
        default:
            return state;
    }
}