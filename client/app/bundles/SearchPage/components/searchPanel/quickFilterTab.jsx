import React, { Component } from 'react';
import FilterItem from './filterItem';
import selectTab from '../../actions/selectTab';
import _ from 'lodash';

export default class QuickFilterTab extends Component {
  onMoreClick(tab) {
    const { dispatch } = this.props;

    // This is only for selecting the other tabs but
    // the index starts from zero so offset it
    dispatch(selectTab(tab + 1))
  }

  render() {
    const { filterFacets, activeFilters, facetNameMappings, dispatch } = this.props;
    const facetGroups = _.map(_.toPairs(filterFacets), (facetBundle, index) => {
      const [facet, values] = facetBundle;
      const facetValues = _.map(
        _.take(
          _.sortBy(_.toPairs(values), (v) => {
            const [name, count] = v;
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
