import ReactOnRails from 'react-on-rails';
import SearchPageStore from '../store/searchPageStore';
import SearchPageApp from './SearchPageApp';

ReactOnRails.register({ SearchPageApp })
ReactOnRails.registerStore({ SearchPageStore })
