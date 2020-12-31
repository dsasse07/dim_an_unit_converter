class Converter
  # here will be your CLI!
  # it is not an AR class so you need to add attr
  
  attr_accessor :path, :starting_unit, :ending_unit, :this_rounds_factors, :steps, :round

  def initialize 
    @path = []
    @round = []
    @solution_factors = []
  end

  def run
    initialize_problem
    @this_rounds_factors = get_factors(@starting_unit)
    mark_used
    self.path << self.this_rounds_factors
    while !complete?
      collect_possible_factors
    end
    reset_conversion_factors
    identify_solution_path
    print_solution  ####### Left off here. Need to format print, make more seeds, test other pathways, make interface ###
    binding.pry

  end

  private

  def calculate_final_value

  end
  
  def print_solution
    string = [@starting_unit.unit, " --> "]
    string << next_unit_name
    string << @ending_unit.unit
    puts "#{string.flatten.join}"
  end

  def next_unit_name
    previous = @starting_unit
    @solution_factors.map do |factor| 
      if factor.unit1 == previous 
        previous = factor.unit2
        return factor.unit2.unit + " --> "
      else 
        previous = factor.unit1
        return factor.unit1.unit + " --> "
      end
    end
  end


  
  def initialize_problem
    # @starting_unit = Unit.all.sample
    # @ending_unit = Unit.where.not(id: self.starting_unit.id).sample
    @starting_unit = Unit.first
    @ending_unit = Unit.last
    set_start_value
    @steps = 1
  end

  def set_start_value
    @starting_value = random_float_generator
    @starting_sig_figs = set_sig_figs
    @starting_value = @starting_value.signif(@starting_sig_figs)
    validate_sig_figs
  end

  def set_sig_figs
    @starting_sig_figs = random_num_sig_figs
  end

  # def validate_sig_figs
  #   if Math.log(@starting_value, 10) < @starting_sig_figs
  #     @starting_sig_figs = @starting_value.to_s.count("^0")
  #   elsif @starting_value.to_s.first == 0
  #     @starting_sig_figs = @starting_value.match(/[^0\.0+]\d*/).count
  #   end

  # end

  def random_num_sig_figs
    (1..4).to_a.sample
  end
  
  def random_float_generator
    rand * random_power_of_10
  end

  def random_power_of_10
    10 ** (0..4).to_a.sample
  end

  def identify_solution_path
    while !self.path.empty?
      @solution_factors.first.nil? ? test_unit1 = @ending_unit : test_unit1 = @solution_factors.first.unit1
      @solution_factors.first.nil? ? test_unit2 = @ending_unit : test_unit2 = @solution_factors.first.unit2

      final_cf_index = self.path.last.length - 1

      if self.path.last[final_cf_index].class == Array
        step = self.path.last[final_cf_index].find do |cf| 
          cf.unit1_id == test_unit1.id || 
          cf.unit2_id == test_unit1.id || 
          cf.unit2_id == test_unit2.id || 
          cf.unit2_id == test_unit2.id
        end 
        @solution_factors.unshift(step) if !step.nil?
      elsif self.path.last[final_cf_index].class == ConversionFactor
        if self.path.last[final_cf_index].unit1_id == test_unit1.id || 
          self.path.last[final_cf_index].unit2_id == test_unit1.id || 
          self.path.last[final_cf_index].unit2_id == test_unit1.id || 
          self.path.last[final_cf_index].unit2_id == test_unit2.id
          
          @solution_factors.unshift(self.path.last[final_cf_index])
        end
      end
      self.path.last.pop
      self.path.reject!(&:empty?)
      break if @solution_factors.first.unit1 == @starting_unit || @solution_factors.first.unit2 == @starting_unit
    end
  end

  def collect_possible_factors
    self.round.clear
    self.steps +=1
    self.path.last.each do |previous_factor|
      self.this_rounds_factors = next_factors(previous_factor)
      mark_used
      self.round << self.this_rounds_factors
    end
    self.path << self.round
  end

  def next_factors(previous_factor)
    ConversionFactor.where(unit1_id: previous_factor.unit1_id, used: false) + ConversionFactor.where(unit1_id: previous_factor.unit2_id, used: false)+ ConversionFactor.where(unit2_id: previous_factor.unit1_id, used: false)+ ConversionFactor.where(unit2_id: previous_factor.unit1_id, used: false)
  end


  def get_factors(unit)
    ConversionFactor.where(unit1_id: unit.id, used: false) + ConversionFactor.where(unit2_id: unit.id, used: false)
  end

  def mark_used
    @this_rounds_factors.each {|factor| factor.update(used: true)}
  end

  def reset_conversion_factors
    ConversionFactor.update_all(used: false)
  end

  def complete?
    results = self.this_rounds_factors.collect {|factor| matches_ending_unit?(factor)}
    results.any?(true)
  end

  def matches_ending_unit?(factor)
    factor.unit1 == ending_unit || factor.unit2 == ending_unit
  end




  
end

