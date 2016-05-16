import React from 'react';
import { Provider } from 'react-redux';
import SearchBox from '../containers/SearchBox';
import ReactRails from 'react-on-rails';

export default () => {
  const searchPageStore = ReactRails.getStore('searchPageStore');
  return (
    <Provider store={searchPageStore}>
      <SearchBox />
    </Provider>
  );
};
