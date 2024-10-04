using JuMP, GLPK
using Printf

model = Model(GLPK.Optimizer)

@variable(model, x1 >= 0)  # sencillas
@variable(model, x2 >= 0)  # dobles
@variable(model, x3 >= 0)  # triples
@variable(model, x4 >= 0)  # cuádruples

@objective(model, Max, 1000 * x1 + 1900 * x2 + 2700 * x3 + 3400 * x4)

@constraint(model, 50000 * x1 + 70000 * x2 + 130000 * x3 + 160000 * x4 + 300 * 2000 <= 15000000)

@constraint(model, 0.18 * x1 + 0.28 * x2 + 0.4 * x3 + 0.5 * x4 <= 300 * 0.25 * 0.85)

@constraint(model, x3 + x4 >= 0.25 * (x1 + x2 + x3 + x4))
@constraint(model, x1 >= 0.20 * (x1 + x2 + x3 + x4))
@constraint(model, x2 >= 0.10 * (x1 + x2 + x3 + x4))

optimize!(model)

x1_val = value(x1)
x2_val = value(x2)
x3_val = value(x3)
x4_val = value(x4)
valor_objetivo = objective_value(model)

@printf("Unidades sencillas: %.2f\n", x1_val)
@printf("Unidades dobles: %.2f\n", x2_val)
@printf("Unidades triples: %.2f\n", x3_val)
@printf("Unidades cuádruples: %.2f\n", x4_val)
@printf("Valor objetivo: %.2f\n", valor_objetivo)
