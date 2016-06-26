import React from 'react';
import { Provider } from 'react-redux';
import SearchTab from '../containers/SearchTab';
import ReactRails from 'react-on-rails';

export default () => {
  const searchPageStore = ReactRails.getStore('searchPageStore');
  return (
    <Provider store={searchPageStore}>
      <SearchTab/>
    </Provider>
  );
};
