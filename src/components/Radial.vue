<template>
  <div>
    <div>
      <apexchart type="radialBar" height="390" :options="chartOptions" :series="series"></apexchart>
    </div>
  </div>
</template>
<script>
export default {
  name: "Radial",
  props: {
    chartDatas: {
      type: Array,
      required: true
    }
  },

  data() {
    return {
      newChartDatas: this.chartDatas,
      series: [],

      chartOptions: {
        labels: [],

        //plotOptions
        plotOptions: {
          radialBar: {
            offsetY: 0,
            startAngle: 0,
            endAngle: 270,
            hollow: {
              margin: 5,
              size: "30%",
              background: "transparent",
              image: undefined
            },
            dataLabels: {
              name: {
                show: false
              },
              value: {
                show: false
              }
            }
          }
        },

        colors: ["#1ab7ea", "#0084ff", "#39539E", "#0077B5"],

        legend: {
          show: true,
          floating: true,
          fontSize: "16px",
          position: "left",
          offsetX: 160,
          offsetY: 15,
          labels: {
            useSeriesColors: true
          },
          markers: {
            size: 0
          },
          formatter: function(seriesName, opts) {
            return (
              seriesName + ":  " + opts.w.globals.series[opts.seriesIndex] + "%"
            );
          },
          itemMargin: {
            vertical: 3
          }
        },

        //responsive
        responsive: [
          {
            breakpoint: 640,
            options: {
              legend: {
                position: "left-top",
                fontSize: "10px"
              },
              chart: {
                height: 300
              }
            }
          }
        ]
      }
    };
  },

  //******************************************************** *//

  created() {
    this.updateSeries();
    this.updateLabel();
  },

  beforeUpdate() {
    this.updateSeries();
    this.updateLabel();
  },

  methods: {
    updateSeries() {
      let newserie = this.series;
      newserie = this.newChartDatas.map(el =>
        newserie.push(Math.round((el.sum * 100) / el.survey_topicQuote))
      );
    },

    updateLabel() {
      let newlabel = this.chartOptions.labels;

      newlabel = this.newChartDatas.map(el =>
        newlabel.push(el.survey_topicTitle)
      );
    }
  }
};
</script>

