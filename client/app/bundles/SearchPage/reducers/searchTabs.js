import { SELECT_CAT } from '../actions/searchTabs';
import { LOAD_STATE_FROM_PAGE } from '../actions/loadStateFromPage';
import { handleActions } from 'redux-actions';

// export default function (state = {}, action) {
//     console.log('[category] was called with state', state, 'and action', action)

//     switch (action.type) {
//         case SELECT_CAT:
//             return {
//                 ...state,
//                 searchTabs: {
//                     active: 2
//                   }
//             }
//       case LOAD_STATE_FROM_PAGE:
//         return  action.payload.searchTabs;
//         default:
//             return state;
//     }
// }

export default handleActions({
  [SELECT_CAT]: (state, action) => {
    console.log('handleActions' + action.payload);
    return {...state, active_tab:action.payload}
  },
  [LOAD_STATE_FROM_PAGE]: (state, action) => {
    return action.payload.searchTabs;
  },
}, {});