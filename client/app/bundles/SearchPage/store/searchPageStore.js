import { compose, createStore, applyMiddleware, combineReducers } from 'redux';
import * as reducers from '../reducers'

const reducer = combineReducers(reducers);

export default createStore(
  reducer,
  undefined,
  window.devToolsExtension ? window.devToolsExtension() : undefined
);
