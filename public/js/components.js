class MainTitle extends React.Component {
  render() {
    return(<h1>Welcome to Ask or Bid!</h1>);
  }
}

ReactDOM.render(
  <MainTitle />, document.getElementById('index-title')
);

class StockTable extends React.Component {
  constructor(){
    super();

    this.state = { stockItems: [] };
  }

  componentWillMount() {
    this._fetchTrendResults();

  }

  render(){
    console.log(this.state.stockItems);
    return(
      <table className='table table-striped'>
        <thead>
          <tr>
            <th>Symbol</th>
            <th>Evaluation</th>
          </tr>
        </thead>
        <tbody>
          {this._getStockItems()}
        </tbody>
      </table>
    );
  }

  _fetchTrendResults() {
    jQuery.ajax({
      method: 'GET',
      url: '/api/trend-results.json',
      success: (stockItems) => {
        console.log(stockItems)
        this.setState({ stockItems });
      }
    });
  }

  _getStockItems(){
    return this.state.stockItems.map((item) => {
      return(<StockItem symbol={item.symbol} evaluation={item.evaluation} />);
    });
  }
}

ReactDOM.render(
  <StockTable />, document.getElementById('stock-container')
);

class StockItem extends React.Component {
  render(){
    return(
      <tr>
        <td>{this.props.symbol}</td>
        <td>{this.props.evaluation}</td>
      </tr>
    );
  }
}
