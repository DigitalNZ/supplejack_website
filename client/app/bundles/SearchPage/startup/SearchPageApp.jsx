import React from 'react';
import { Provider } from 'react-redux';

import SearchPageStore from '../store/searchPageStore';
import SearchPanel from '../containers/SearchPanel';

export default _ => {
  return (
    <Provider store={SearchPageStore}>
      <SearchPanel />
    </Provider>
  );
};
