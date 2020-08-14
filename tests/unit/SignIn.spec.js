import { shallowMount } from '@vue/test-utils'
import SignIn from '@/components/SignIn.vue'

describe('SignIn', () => {
    // Now mount the component and you have the wrapper
    const wrapper = shallowMount(SignIn)
  
   
    // it's also easy to check for the existence of elements
    const but = wrapper.find('button')
    

it('has a button', () => {
  expect(but.exists()).toBe(true)
})

it('has the hook `mounted`', () => {
  expect(typeof SignIn.mounted).toBe('function')
})

  })