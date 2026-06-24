---
name: crit
description: brainstorm with AI using the CRIT framework to generate and evaluate ideas.
disable-model-invocation: true
---

## Purpose

This skill implements the CRIT (Context-Request-Input-Tone) framework for structured brainstorming and idea evaluation. It transforms abstract discussions into concrete, actionable outcomes through systematic analysis and iterative refinement.

## Core Workflow

### Step 1: Context Analysis
Before generating ideas, establish the foundation:

1. **Identify the Core Domain**
   - What field, industry, or subject area?
   - What are the key constraints (time, resources, technical limitations)?
   - Who is the target audience and their expertise level?

2. **Assess Current State**
   - What problems or opportunities exist?
   - What has been tried before (if applicable)?
   - What resources are available?

**Completion Criterion**: Clear understanding of domain, constraints, and current state documented.

### Step 2: Request Clarification
Structure the brainstorming request:

1. **Define the Specific Goal**
   - What concrete outcome do you want?
   - What success criteria will be used?
   - What is the expected timeline?

2. **Gather Input Requirements**
   - What information is needed to proceed?
   - What assumptions should be validated?
   - What data or resources are required?

**Completion Criterion**: Specific goal and input requirements clearly defined.

### Step 3: Idea Generation
Generate diverse, high-quality ideas:

1. **Divergent Thinking Phase**
   - Generate 5-10 initial concepts without judgment
   - Apply different perspectives (technical, business, user experience)
   - Include both obvious and unconventional options

2. **Convergent Analysis Phase**
   - Evaluate each idea against success criteria
   - Score ideas on feasibility, impact, and alignment
   - Identify patterns and synergies between ideas

**Completion Criterion**: Minimum 5 distinct ideas generated and evaluated with scores.

### Step 4: Iterative Refinement
Improve selected ideas:

1. **Select Top Candidates**
   - Choose 2-3 ideas with highest potential
   - Detail implementation approach for each
   - Identify risks and mitigation strategies

2. **Develop Action Plans**
   - Break down into concrete steps
   - Assign priorities and dependencies
   - Define success metrics and checkpoints

**Completion Criterion**: 2-3 refined ideas with detailed action plans.

### Step 5: Tone & Delivery
Adapt communication to the audience:

1. **Choose Appropriate Role**
   - Subject Matter Expert for technical depth
   - Consultant for strategic guidance
   - Teacher for complex concepts
   - Collaborator for co-creation
   - Analyst for multi-perspective evaluation

2. **Structure Response**
   - Lead with clear, actionable solutions
   - Organize information logically and concisely
   - Include examples or analogies for clarity
   - Suggest next steps and follow-up questions

**Completion Criterion**: Response delivered in appropriate tone with clear structure.

## Quality Guardrails

- Never generate ideas without clear context and goals
- Always evaluate ideas against defined success criteria
- Maintain transparency about assumptions and limitations
- Encourage iteration and collaboration throughout the process
- Ensure all recommendations are practical and actionable

## Trigger Hints

Load this skill when the user asks to:
- Generate ideas for a specific problem or opportunity
- Brainstorm solutions with structured evaluation
- Get expert guidance through systematic analysis
- Develop actionable plans from abstract concepts
- Evaluate multiple approaches to a challenge

## Output Format

Return results in this structure:

1. **Context Analysis**: Documented understanding of domain and constraints
2. **Request Clarification**: Defined goals and input requirements
3. **Idea Generation**: List of ideas with evaluation scores
4. **Refined Solutions**: Detailed action plans for top candidates
5. **Next Steps**: Suggested follow-up actions and questions

Each section should be clearly labeled and include completion criteria verification.

