import React, { Component } from 'react';
import toggleFilter from '../../actions/filters';
import classNames from 'classnames';
import _ from 'lodash';

export default class FilterItem extends Component {
  handleFilterClick(facet, label) {
    const { dispatch } = this.props;

    dispatch(toggleFilter({facet, value: label}))
  }

  render() {
    const { label, count, facet, activeFilters } = this.props;
    const active = _.includes(activeFilters, label)
    const aClass = classNames({active})

    return (
      <a 
        className={aClass}
        onClick={this.handleFilterClick.bind(this, facet, label)}
        >
        {label} <span className='count'>{count.toLocaleString()}</span>
      </a>
    );
  }
}
