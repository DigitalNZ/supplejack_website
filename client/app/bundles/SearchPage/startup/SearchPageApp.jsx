import React from 'react';
import { Provider } from 'react-redux';

import SearchPageStore from '../store/searchPageStore';
import SearchPanel from '../containers/SearchPanel';
import ReactRails from 'react-on-rails';

export default _ => {
  const searchPageStore = ReactRails.getStore('searchPageStore')
  return (
    <Provider store={searchPageStore}>
      <SearchPanel />
    </Provider>
  );
};
