/* eslint-disable prettier/prettier */
<template>
  <div>
    <div id="chart">
      <apexchart type="radar" :options="chartOptions" :series="series"></apexchart>
    </div>
  </div>
</template>

<script>
export default {
  name: "Radar",
  props: {
    chartDatas: {
      type: Array,
      required: true
    }
  },

  data() {
    return {
      newChartDatas: this.chartDatas,

      series: [
        {
          name: "Niveau maximal",
          data: []
        },
        {
          name: "Résultat",
          data: []
        }
      ],

      chartOptions: {
        legend: {
          show: true,
          position: "top"
        },

        stroke: {
          show: true
        },
        fill: {
          opacity: 0.1
        },

        xaxis: {
          categories: [],
          labels: {
            show: true,
            style: {
              fontSize: "0.8rem",
              fontWeight: 700
            },
            offsetY: -10
          }
        },
        yaxis: {
          show: false
        },
        dataLabels: {
          enabled: true,
          background: {
            enabled: true,
            borderRadius: 2
          }
        },
        responsive: [
          {
            breakpoint: 640,
            options: {
              legend: {
                fontSize: "10px"
              },
              chart: {
                height: 300
              },
              xaxis: {
                labels: {
                  show: true,
                  style: {
                    fontSize: "0.7rem"
                  },
                  offsetY: -10
                }
              }
            },

            xaxis: {
              labels: {
                style: {
                  fontSize: "0.4rem"
                }
              }
            }
          }
        ]
      }
    };
  },

  created() {
    this.updateCategories();
    this.updateSerieMax();
    this.updateSerieCurrentSurvey();
  },

  beforeUpdate() {
    this.updateCategories();
    this.updateSerieMax();
    this.updateSerieCurrentSurvey();
  },

  methods: {
    updateCategories() {
      let newCategorie = this.chartOptions.xaxis.categories;
      newCategorie = this.newChartDatas.map(el =>
        newCategorie.push(el.survey_topicTitle)
      );
    },

    updateSerieMax() {
      let newSerieMax = this.series[0].data;
      newSerieMax = this.newChartDatas.map(el =>
        newSerieMax.push(el.survey_topicQuote)
      );
    },

    updateSerieCurrentSurvey() {
      let newSerieCurrentSurvey = this.series[1].data;
      newSerieCurrentSurvey = this.newChartDatas.map(el =>
        newSerieCurrentSurvey.push(el.sum)
      );
    }
  }
};
</script>



