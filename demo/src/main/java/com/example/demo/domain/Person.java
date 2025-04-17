package com.example.demo.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Represents a person with basic personal information.
 *
 * <p>This class is part of the internal demo library and uses Lombok
 * annotations to generate boilerplate code.</p>
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Person {

   private Long id;

   private String firstName;

   private String lastName;

   private int age;

}
