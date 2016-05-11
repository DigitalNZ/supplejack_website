import React, { Component, PropTypes } from 'react';
import FilterItem from './filterItem';
import selectTab from '../../actions/selectTab';
import _ from 'lodash';

export default class QuickFilterTab extends Component {
  static propTypes = {
    filterFacets: PropTypes.objectOf(PropTypes.number).isRequired,
    activeFilters: PropTypes.arrayOf(
      PropTypes.shape({
        facet: PropTypes.string,
        value: PropTypes.string
      })
    ).isRequired,
    dispatch: PropTypes.func.isRequired
  }

  onMoreClick(tab) {
    const { dispatch } = this.props;

    // This is only for selecting the other tabs but
    // the index starts from zero so offset it
    dispatch(selectTab(tab + 1))
  }

  render() {
    const { filterFacets, activeFilters, facetNameMappings, dispatch } = this.props;

    // This mess generates each column in the Quick Filters tab
    // _.toPairs converts an object like {foo: 'bar', baz: 'qux'} into an array
    // [['foo', 'bar'], ['baz', 'qux']]
    const facetGroups = _.map(_.toPairs(filterFacets), (facetBundle, index) => {
      const [facet, values] = facetBundle;

      // This monstrosity does the following
      // sort all columns but date ascending, date is sorted descending
      // take the first five items from the sorted columns
      // map them into li's holding a FilterItem
      const facetValues = _.map(
        _.take(
          _.sortBy(_.toPairs(values), (v) => {
            const [name, count] = v;
            // This basically makes use of the fact that only the dates are numbers
            // So if it can't be parsed into a number, sort it normally
            // otherwise invert the value to fake a descending sort order
            if(_.isNaN(_.toNumber(name)))
              return name 
            else
              // Invert the number so that it sorts descending instead of ascending
              return -(_.toNumber(name))
          })
        , 5),
        (valueBundle, index) => {
          const [name, count] = valueBundle;

          return (
            <li key={index}>
              <FilterItem
                label={name}
                count={count}
                facet={facet}
                activeFilters={activeFilters}
                dispatch={dispatch}
              />
            </li>
          );
        })

      return (
        <li key={index}>
          <section>
            {facetNameMappings[facet]}
            <ul>
              {facetValues}
            </ul>
            <li>
              <a className='more' onClick={this.onMoreClick.bind(this, index)}>More +</a>
            </li>
          </section>
        </li>
      )
    });

    return (
      <div className='quick-filters content active'>
        <ul className={'medium-block-grid-' + _.keys(filterFacets).length}>
          {facetGroups}
        </ul>
      </div>
    );
  }
}
