import React, { Component } from 'react';

export default class FilterTab extends Component {
  render() {
    const { values } = this.props;

    const tabContent = _.map(values, (count, label) => {
      return (
        <a>{label} <span className='count'>{count.toLocaleString()}</span></a>
      );
    })

    return (
      <div className='content active'>
        <section>
          <ul className='facet-list'>
            {tabContent}
          </ul>
        </section>
      </div>
    );
  }
}
