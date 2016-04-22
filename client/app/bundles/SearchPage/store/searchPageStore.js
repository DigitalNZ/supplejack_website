import { compose, createStore, applyMiddleware, combineReducers } from 'redux';
import thunk from 'redux-thunk';
import * as reducers from '../reducers'

const reducer = combineReducers(reducers);

export default createStore(
  reducer,
  undefined,
  compose(
    applyMiddleware(
      thunk
    ),
    window.devToolsExtension ? window.devToolsExtension() : f => f
  )
);
